// Copyright (c) 2016, Kleak. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import "package:angular2_lazy/components/home.dart";
import "package:angular2_lazy/components/lazy_one.dart" deferred as lazyOne;
import "package:angular2_lazy/components/lazy_two.dart" deferred as lazyTwo;

Future<Type> lazyOneLoader() async {
  await lazyOne.loadLibrary();
  return lazyOne.LazyOne;
}

Future<Type> lazyTwoLoader() async {
  await lazyTwo.loadLibrary();
  return lazyTwo.LazyTwo;
}

@Component(
    selector: 'my-app',
    styleUrls: const ['app_component.css'],
    templateUrl: 'app_component.html',
    directives: const [ROUTER_DIRECTIVES, Home])
@RouteConfig(const [
  const Route(name: 'Home', path: '/', component: Home, useAsDefault: true),
  const AsyncRoute(name: 'LazyOne', path: '/lazyOne', loader: lazyOneLoader),
  const AsyncRoute(name: 'LazyTwo', path: '/lazyTwo', loader: lazyTwoLoader),
  const Redirect(name: 'RHome', path: '**', redirectTo: const ['./Home'])
])
class AppComponent {}
