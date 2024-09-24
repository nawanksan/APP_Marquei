import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marquei/src/home/presentation/pages/home_page.dart';
import 'package:marquei/widgets/custom_appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets(
      'deve mostrar um indicador de carregamento enquanto os dados estão sendo buscados',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomePage()));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Exibe nome completo do usuário corretamente',
      (WidgetTester tester) async {
    // Simula os dados do SharedPreferences
    SharedPreferences.setMockInitialValues({
      'user_profile': '{"first_name": "John", "last_name": "Doe"}',
    });

    // Construa a tela Home
    await tester.pumpWidget(
      MaterialApp(
        home: HomePage(), // Ajuste conforme o nome da sua tela inicial
      ),
    );

    // Faz a tela "carregar" (completa o Future)
    await tester.pump(); // Aqui o Future completa e a UI deve atualizar.

    // Verifica se o nome completo do usuário é exibido corretamente na AppBar
    expect(find.text('John'), findsOneWidget);
    expect(find.text('Doe'), findsOneWidget);
  });

  testWidgets('Texto Estatísticas do seu negócio está presente na tela inicial',
      (WidgetTester tester) async {
    // Cria o mock
    SharedPreferences.setMockInitialValues({
      'user_profile': '{"first_name": "John", "last_name": "Doe"}',
    });

    await tester.pumpWidget(
      MaterialApp(
        home: HomePage(), // Passa o mock para a HomePage
      ),
    );

    await tester.pumpAndSettle(); // Aguarda animações e carregamentos

    // Verifica se o texto esperado está presente
    expect(find.text('Estatísticas do seu negócio'), findsOneWidget);
  });

  testWidgets('Texto Próximos Agendamentos está presente na tela inicial',
      (WidgetTester tester) async {
    // Cria o mock
    SharedPreferences.setMockInitialValues({
      'user_profile': '{"first_name": "John", "last_name": "Doe"}',
    });

    await tester.pumpWidget(
      MaterialApp(
        home: HomePage(), // Passa o mock para a HomePage
      ),
    );

    await tester.pumpAndSettle(); // Aguarda animações e carregamentos

    // Verifica se o texto esperado está presente
    expect(find.text('Seus Próximos Agendamentos'), findsOneWidget);
  });

  testWidgets('Tela inicial carrega corretamente', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({
      'user_profile': '{"first_name": "John", "last_name": "Doe"}',
    });

    await tester.pumpWidget(MaterialApp(home: HomePage()));

    await tester.pumpAndSettle();

    // Verifica se a AppBar está presente
    expect(find.text('John'), findsOneWidget);
  });

  testWidgets('Widget customizado aparece na tela',
      (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({
      'user_profile': '{"first_name": "John", "last_name": "Doe"}',
    });

    await tester.pumpWidget(MaterialApp(home: HomePage()));
    await tester.pumpAndSettle();

    // Verifica se o widget customizado aparece
    expect(
        find.byType(CustomAppBar), findsOneWidget); // Substitua pelo seu widget
  });

  testWidgets('boas vindas aparece na tela', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({
      'user_profile': '{"first_name": "John", "last_name": "Doe"}',
    });

    await tester.pumpWidget(MaterialApp(home: HomePage()));
    await tester.pumpAndSettle();

    // Verifica se o widget customizado aparece
    expect(
        find.text('Boas vindas,'), findsOneWidget); // Substitua pelo seu widget
  });

  testWidgets('Verifica se o GestureDetector foi pressionado',
      (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({
      'user_profile': '{"first_name": "John", "last_name": "Doe"}',
    });

    await tester.pumpWidget(MaterialApp(home: HomePage()));
    await tester.pumpAndSettle();

    // Simula o clique no GestureDetector
    await tester.tap(find.byKey(Key('GestureDetectorKey')));
    await tester.pump(); // Aguarda o pump para processar a ação

    // Verifica se o GestureDetector foi realmente pressionado
    expect(find.text('Sair'), findsOneWidget); // Agora deve ser verdadeiro
  });

  testWidgets('Verifica se a rolagem está implemetada corretamente',
      (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({
      'user_profile': '{"first_name": "John", "last_name": "Doe"}',
    });

    await tester.pumpWidget(MaterialApp(home: HomePage()));
    await tester.pumpAndSettle();

    // Verifica se o scroll foi implemetado
    expect(find.byType(SingleChildScrollView),
        findsOneWidget); // Substitua pelo último item esperado
  });
}
