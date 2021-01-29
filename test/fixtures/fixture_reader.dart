import 'dart:io';

String fixture(String name) =>
    File('/Users/tobiasoho/Git/numbers_trivia_app/test/fixtures/$name')
        .readAsStringSync();
