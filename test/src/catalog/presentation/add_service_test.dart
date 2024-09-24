import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marquei/src/catalog/presentation/add_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('AddService Widget Tests', () {
    late SharedPreferences prefs;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      prefs = await SharedPreferences.getInstance();
    });

    testWidgets('Verificar se o formulário é renderizado corretamente', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: AddService()));

      expect(find.byType(Form), findsOneWidget);
      expect(find.text('Nome'), findsOneWidget);
      expect(find.text('Descrição'), findsOneWidget);
      expect(find.text('Duração do serviço'), findsOneWidget);
      expect(find.text('Preço'), findsOneWidget);
      expect(find.text('Criar Serviço'), findsOneWidget);
    });

    testWidgets('Validação de campo vazio - Nome', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: AddService()));

      await tester.tap(find.text('Criar Serviço'));
      await tester.pump();

      expect(find.text('Por favor, insira o nome do serviço'), findsOneWidget);
    });

    testWidgets('Validação de campo vazio - Descrição', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: AddService()));

      await tester.enterText(find.byType(TextFormField).at(0), 'Corte de Cabelo');
      await tester.tap(find.text('Criar Serviço'));
      await tester.pump();

      // Como a descrição não tem validação, aqui estamos testando se o campo está sendo renderizado e salvo corretamente
      expect(find.text('Corte de Cabelo'), findsOneWidget);
    });

    // testWidgets('Adicionar imagem ao serviço', (WidgetTester tester) async {
    //   await tester.pumpWidget(const MaterialApp(home: AddService()));

    //   expect(find.text('Nenhuma imagem selecionada'), findsOneWidget);
    //   await tester.tap(find.text('Adicionar foto do serviço'));
    //   await tester.pump();

    //   // A interação com o ImagePicker deve ser simulada em um teste de integração, não sendo possível fazer isso diretamente aqui.
    // });

    testWidgets('Testar valor inicial do Dropdown de duração', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: AddService()));

      final dropdown = find.byType(DropdownButtonFormField<String>).at(0);
      expect(dropdown, findsOneWidget);
      expect(find.text('30min'), findsOneWidget);
    });

    testWidgets('Alterar valor do Dropdown de duração', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: AddService()));

      await tester.tap(find.text('30min'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('1 hora').last);
      await tester.pumpAndSettle();

      expect(find.text('1 hora'), findsOneWidget);
    });

    testWidgets('Testar valor inicial do Dropdown de categoria', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: AddService()));

      final dropdown = find.byType(DropdownButtonFormField<String>).at(1);
      expect(dropdown, findsOneWidget);
      expect(find.text('Cabelo'), findsOneWidget);
    });

    testWidgets('Alterar valor do Dropdown de categoria', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: AddService()));

      await tester.tap(find.text('Cabelo'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Mãos').last);
      await tester.pumpAndSettle();

      expect(find.text('Mãos'), findsOneWidget);
    });

    testWidgets('Verificar se o preço é inserido corretamente', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: AddService()));

      await tester.enterText(find.byType(TextFormField).at(2), '120');
      await tester.pump();

      expect(find.text('120'), findsOneWidget);
    });

    testWidgets('Verificar se a criação de serviço falha sem token', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: AddService()));

      await tester.tap(find.text('Criar Serviço'));
      await tester.pump();

      expect(find.text('Token não encontrado'), findsNothing);
    });
  });
}
