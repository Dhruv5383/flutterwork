// GENERATED CODE — DO NOT MODIFY BY HAND
// Normally produced by: dart run build_runner build
// Included here so the project runs without the code-gen step.

//part of 'task_model.dart';

// ──────────────────────────────────────────────
//  TaskAdapter
// ──────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'Q2 Task model.dart';

class TaskAdapter extends TypeAdapter<Task> {
  @override
  final int typeId = 0;

  @override
  Task read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Task(
      id:          fields[0] as String,
      title:       fields[1] as String,
      description: fields[2] as String,
      isCompleted: fields[3] as bool,
      createdAt:   fields[4] as DateTime,
      dueDate:     fields[5] as DateTime?,
      priority:    fields[6] as TaskPriority,
      category:    fields[7] as TaskCategory,
      completedAt: fields[8] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.isCompleted)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.dueDate)
      ..writeByte(6)
      ..write(obj.priority)
      ..writeByte(7)
      ..write(obj.category)
      ..writeByte(8)
      ..write(obj.completedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is TaskAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}

// ──────────────────────────────────────────────
//  TaskPriorityAdapter
// ──────────────────────────────────────────────
class TaskPriorityAdapter extends TypeAdapter<TaskPriority> {
  @override
  final int typeId = 1;

  @override
  TaskPriority read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:  return TaskPriority.low;
      case 1:  return TaskPriority.medium;
      case 2:  return TaskPriority.high;
      default: return TaskPriority.medium;
    }
  }

  @override
  void write(BinaryWriter writer, TaskPriority obj) {
    switch (obj) {
      case TaskPriority.low:    writer.writeByte(0); break;
      case TaskPriority.medium: writer.writeByte(1); break;
      case TaskPriority.high:   writer.writeByte(2); break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is TaskPriorityAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}

// ──────────────────────────────────────────────
//  TaskCategoryAdapter
// ──────────────────────────────────────────────
class TaskCategoryAdapter extends TypeAdapter<TaskCategory> {
  @override
  final int typeId = 2;

  @override
  TaskCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:  return TaskCategory.personal;
      case 1:  return TaskCategory.work;
      case 2:  return TaskCategory.shopping;
      case 3:  return TaskCategory.health;
      case 4:  return TaskCategory.other;
      default: return TaskCategory.personal;
    }
  }

  @override
  void write(BinaryWriter writer, TaskCategory obj) {
    switch (obj) {
      case TaskCategory.personal: writer.writeByte(0); break;
      case TaskCategory.work:     writer.writeByte(1); break;
      case TaskCategory.shopping: writer.writeByte(2); break;
      case TaskCategory.health:   writer.writeByte(3); break;
      case TaskCategory.other:    writer.writeByte(4); break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is TaskCategoryAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}