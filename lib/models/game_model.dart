import 'dart:math';

import 'package:flutter/material.dart';
import 'package:game/main.dart';
import 'package:game/models/direction.dart';
import 'package:game/services/local_cache.dart';

class GameModel extends ChangeNotifier {
  final LocalCache _cache = di<LocalCache>();

  List<List<int>> _grid = List.generate(4, (_) => List.filled(4, 0));
  int _score = 0;
  int _bestScore = 0;
  bool _gameOver = false;
  bool _won = false;
  final Random _random = Random();

  List<List<int>> get grid => _grid;
  int get score => _score;
  int get bestScore => _bestScore;
  bool get gameOver => _gameOver;
  bool get won => _won;

  GameModel() {
    _initGame();
  }

  void _initGame() async {
    _bestScore = await getHighScore();
    _grid = List.generate(4, (_) => List.filled(4, 0));
    _score = 0;
    _gameOver = false;
    _won = false;
    _addRandomTile();
    _addRandomTile();
    notifyListeners();
  }

  set won(bool value) {
    _won = value;
    notifyListeners();
  }

  void newGame() {
    _initGame();
  }

  Future<void> saveHighScore(int score) async {
    _cache.setUserPreference(CacheKeys.highScores, score);
    notifyListeners();
  }

  Future<int> getHighScore() async {
    final highScore = await _cache.getUserPreference<int?>(
      CacheKeys.highScores,
    );
    return highScore ?? 0;
  }

  void _addRandomTile() {
    List<Point<int>> emptyCells = [];
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (_grid[i][j] == 0) {
          emptyCells.add(Point(i, j));
        }
      }
    }

    if (emptyCells.isNotEmpty) {
      Point<int> randomCell = emptyCells[_random.nextInt(emptyCells.length)];
      _grid[randomCell.x][randomCell.y] = _random.nextDouble() < 0.9 ? 2 : 4;
    }
  }

  Future<bool> move(Direction direction) async {
    List<List<int>> newGrid = List.generate(4, (i) => List.from(_grid[i]));
    bool moved = false;
    int addedScore = 0;

    switch (direction) {
      case Direction.left:
        for (int i = 0; i < 4; i++) {
          List<int> row = newGrid[i].where((cell) => cell != 0).toList();
          for (int j = 0; j < row.length - 1; j++) {
            if (row[j] == row[j + 1]) {
              row[j] *= 2;
              addedScore += row[j];
              row.removeAt(j + 1);
              if (row[j] == 2048 && !_won) {
                _won = true;
              }
            }
          }
          row.addAll(List.filled(4 - row.length, 0));
          newGrid[i] = row;
        }
        break;
      case Direction.right:
        for (int i = 0; i < 4; i++) {
          List<int> row = newGrid[i].where((cell) => cell != 0).toList();
          for (int j = row.length - 1; j > 0; j--) {
            if (row[j] == row[j - 1]) {
              row[j] *= 2;
              addedScore += row[j];
              row.removeAt(j - 1);
              j--;
              if (row[j] == 2048 && !_won) {
                _won = true;
              }
            }
          }
          row.insertAll(0, List.filled(4 - row.length, 0));
          newGrid[i] = row;
        }
        break;
      case Direction.up:
        for (int j = 0; j < 4; j++) {
          List<int> column = [];
          for (int i = 0; i < 4; i++) {
            if (newGrid[i][j] != 0) {
              column.add(newGrid[i][j]);
            }
          }
          for (int i = 0; i < column.length - 1; i++) {
            if (column[i] == column[i + 1]) {
              column[i] *= 2;
              addedScore += column[i];
              column.removeAt(i + 1);
              if (column[i] == 2048 && !_won) {
                _won = true;
              }
            }
          }
          column.addAll(List.filled(4 - column.length, 0));
          for (int i = 0; i < 4; i++) {
            newGrid[i][j] = column[i];
          }
        }
        break;
      case Direction.down:
        for (int j = 0; j < 4; j++) {
          List<int> column = [];
          for (int i = 0; i < 4; i++) {
            if (newGrid[i][j] != 0) {
              column.add(newGrid[i][j]);
            }
          }
          for (int i = column.length - 1; i > 0; i--) {
            if (column[i] == column[i - 1]) {
              column[i] *= 2;
              addedScore += column[i];
              column.removeAt(i - 1);
              i--;
              if (column[i] == 2048 && !_won) {
                _won = true;
              }
            }
          }
          column.insertAll(0, List.filled(4 - column.length, 0));
          for (int i = 0; i < 4; i++) {
            newGrid[i][j] = column[i];
          }
        }
        break;
    }

    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (_grid[i][j] != newGrid[i][j]) {
          moved = true;
          break;
        }
      }
    }

    if (moved) {
      _grid = newGrid;
      _score += addedScore;
      if (_score > _bestScore) {
        _bestScore = _score;
        await saveHighScore(score);
        notifyListeners();
      }
      _addRandomTile();
      _checkGameOver();
      notifyListeners();
    }
    return moved;
  }

  void _checkGameOver() {
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (_grid[i][j] == 0) {
          return;
        }
      }
    }

    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 3; j++) {
        if (_grid[i][j] == _grid[i][j + 1]) {
          return;
        }
      }
    }

    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 4; j++) {
        if (_grid[i][j] == _grid[i + 1][j]) {
          return;
        }
      }
    }

    _gameOver = true;
  }
}
