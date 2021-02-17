import "package:equatable/equatable.dart";
import "package:flutter/material.dart";

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  const UserInitial();

  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {
  const UserLoading();

  @override
  List<Object> get props => [];
}

class UserLoaded extends UserState {
  final bool isUserLoaded;

  const UserLoaded({@required this.isUserLoaded});

  @override
  List<Object> get props => [this.isUserLoaded];
}

class UserError extends UserState {
  final String message;

  const UserError({@required this.message});

  @override
  List<Object> get props => [this.message];
}

class UserLoggedOut extends UserState {
  @override
  List<Object> get props => [];
}
