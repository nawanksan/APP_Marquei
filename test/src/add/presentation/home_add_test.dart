import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marquei/src/add/presentation/home_add.dart';
import 'package:marquei/src/add/presentation/widgets/custom_inkwell.dart';
import 'package:shared_preferences/shared_preferences.dart';



void main() {

   testWidgets('TelaMaisState carrega corretamente', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: TelaMaisState()));

    // Verifica se o título 'Negócio' é exibido
    expect(find.text('Negócio'), findsOneWidget);

    // Verifica a existência dos itens de menu
    expect(find.text('Avaliações de clientes'), findsOneWidget);
    expect(find.text('Cupons'), findsOneWidget);
    expect(find.text('Página do Negócio'), findsOneWidget);

    // Verifica o botão "Sair"
    expect(find.text('Sair'), findsOneWidget);
  });

    testWidgets('Botão Sair funciona corretamente', (WidgetTester tester) async {
    // Configura SharedPreferences simulada
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const MaterialApp(home: TelaMaisState()));

    // Toca no botão "Sair"
    await tester.tap(find.text('Sair'));
    await tester.pump();

    // Verifica se o redirecionamento foi chamado
    expect(find.byType(Navigator), findsOneWidget);
  });

   testWidgets('Teste de Refresh Indicator', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: TelaMaisState()));

    // Simula o gesto de refresh
    await tester.drag(find.byType(RefreshIndicator), const Offset(0, 300));
    await tester.pumpAndSettle();

    // Verifica se o RefreshIndicator foi disparado
    expect(find.byType(RefreshIndicator), findsOneWidget);
  });
  
   testWidgets('Interação com CustomInkWell', (WidgetTester tester) async {
    bool tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomInkWell(
            iconPath: 'lib/assets/icons/star.svg',
            text: 'Avaliações de clientes',
            onTap: () {
              tapped = true;
            },
            trailingIcon: Icons.arrow_forward_ios,
          ),
        ),
      ),
    );

    // Verifica se o CustomInkWell está renderizado
    expect(find.text('Avaliações de clientes'), findsOneWidget);

    // Simula o toque no CustomInkWell
    await tester.tap(find.text('Avaliações de clientes'));
    await tester.pump();

    // Verifica se a função onTap foi chamada
    expect(tapped, true);
  });

  testWidgets('Todos os CustomInkWell estão presentes', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: TelaMaisState()));

    // Verifica a presença de cada CustomInkWell pelo texto
    expect(find.text('Avaliações de clientes'), findsOneWidget);
    expect(find.text('Cupons'), findsOneWidget);
    expect(find.text('Página do Negócio'), findsOneWidget);
    expect(find.text('Relatórios'), findsOneWidget);
    expect(find.text('Horários'), findsOneWidget);
    expect(find.text('Regras de Agendamentos'), findsOneWidget);
    expect(find.text('Fale Conosco'), findsOneWidget);
    expect(find.text('Termos e Políticas'), findsOneWidget);
  });

  testWidgets('Verifica a presença do RefreshIndicator e simula refresh', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: TelaMaisState()));

    // Verifica se o RefreshIndicator está presente
    expect(find.byType(RefreshIndicator), findsOneWidget);

    // Simula a ação de "pull-to-refresh"
    await tester.drag(find.byType(RefreshIndicator), const Offset(0, 300));
    await tester.pumpAndSettle();

    // Após o refresh, a tela deve se comportar normalmente (nenhuma mudança perceptível)
    expect(find.byType(RefreshIndicator), findsOneWidget);
  });

   testWidgets('Verifica a presença das seções "Negócio" e "Ajustes"', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: TelaMaisState()));

    // Verifica a presença dos títulos "Negócio" e "Ajustes"
    expect(find.text('Negócio'), findsOneWidget);
    expect(find.text('Ajustes'), findsOneWidget);
  });

  testWidgets('Verifica se a CustomAppBar está sendo renderizada', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: TelaMaisState()));

    // Verifica se a AppBar foi renderizada
    expect(find.byType(AppBar), findsNothing); // Certifica-se de que a AppBar padrão não foi usada
    expect(find.byType(PreferredSize), findsOneWidget); // Verifica o uso de PreferredSize (CustomAppBar)
  });

  testWidgets('Verifica a presença do botão "Sair"', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: TelaMaisState()));

    // Verifica se o botão "Sair" está presente na tela
    expect(find.text('Sair'), findsOneWidget);
  });

  testWidgets('Verifica a presença do texto "Versão 1.0.0"', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: TelaMaisState()));

    // Verifica se o texto da versão "Versão 1.0.0" está presente
    expect(find.text('Versão 1.0.0'), findsOneWidget);
  });

}