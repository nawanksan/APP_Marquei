import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:marquei/src/home/presentation/pages/home_page.dart';
import 'package:marquei/src/login/presentation/pages/login_page.dart';
import 'package:integration_test/integration_test.dart';

void main() {

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'deve enontrar o campo de email e inserir texto',
    (WidgetTester tester) async {
      // TODO: Implementar o teste para a página de login
      // Aqui você pode implementar o teste de UI relacionado à página de login
      //redenrizar a tela de login
      await tester.pumpWidget(MaterialApp(home: LoginPage()));

      // Encontrar o campo de e-mail através de uma chave
      final emailField = find.byKey(Key(
          'emailField')); // Certifique-se de que o TextFormField do e-mail na sua tela de login tenha essa chave

      // Verificar se o campo de e-mail está presente na tela
      expect(emailField, findsOneWidget);

      // Simular a inserção de um e-mail válido
      await tester.enterText(emailField, 'teste@exemplo.com');

      // Verificar se o campo contém o texto inserido
      expect(find.text('teste@exemplo.com'), findsOneWidget);
    },
    
  );

  testWidgets(
    'Deve retornar uma mensagem para um email invalido',
    (WidgetTester tester) async {
      // TODO: Implementar o teste para a página de login
      // Aqui você pode implementar o teste de UI relacionado à página de login
      //redenrizar a tela de login
      await tester.pumpWidget(MaterialApp(home: LoginPage()));

      // Encontrar o campo de e-mail através de uma chave
      final emailField = find.byKey(Key(
          'emailField')); // Certifique-se de que o TextFormField do e-mail na sua tela de login tenha essa chave

      // Verificar se o campo de e-mail está presente na tela
      expect(emailField, findsOneWidget);

      // Simular a inserção de um e-mail inválido
      await tester.enterText(emailField, 'ssssssssss');

      // Simular o toque no botão de login
      final loginButton = find.byKey(Key(
          'loginButton')); // Certifique-se de que o botão de login tenha uma chave
      await tester.tap(loginButton);

      // Pump para aplicar a mudança de estado
      await tester.pump();

      // Verificar se a mensagem de erro de e-mail inválido está sendo exibida
      expect(find.text('Por favor, insira um e-mail válido'), findsOneWidget);
    },
  );

  testWidgets(
    'Deve retornar uma mensagem para um email invalido',
    (WidgetTester tester) async {
      // TODO: Implementar o teste para a página de login
      // Aqui você pode implementar o teste de UI relacionado à página de login
      //redenrizar a tela de login
      await tester.pumpWidget(MaterialApp(home: LoginPage()));

      // Encontrar o campo de e-mail através de uma chave
      final emailField = find.byKey(Key(
          'emailField')); // Certifique-se de que o TextFormField do e-mail na sua tela de login tenha essa chave

      // Verificar se o campo de e-mail está presente na tela
      expect(emailField, findsOneWidget);

      // Simular a inserção de um e-mail inválido
      await tester.enterText(emailField, 'ssssssssss');

      // Simular o toque no botão de login
      final loginButton = find.byKey(Key(
          'loginButton')); // Certifique-se de que o botão de login tenha uma chave
      await tester.tap(loginButton);

      // Pump para aplicar a mudança de estado
      await tester.pump();

      // Verificar se a mensagem de erro de e-mail inválido está sendo exibida
      expect(find.text('Por favor, insira um e-mail válido'), findsOneWidget);
    },
  );

  testWidgets('Deve encontrar o campo de senha', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginPage()));
    final passwordField = find
        .byKey(Key('passwordField')); // Adicione uma chave ao campo de senha
    expect(passwordField, findsOneWidget);
  });

  testWidgets('Deve mostrar erro se o campo de senha estiver vazio',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginPage()));
    final passwordField = find.byKey(Key('passwordField'));
    await tester.enterText(passwordField, ''); // Simular campo vazio
    final loginButton = find.byKey(Key('loginButton'));
    await tester.tap(loginButton);
    await tester.pump();
    expect(find.text('Por favor insira sua senha'), findsOneWidget);
  });

  testWidgets('Deve mostrar erro para senha com menos de 4 caracteres',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginPage()));
    final passwordField = find.byKey(Key('passwordField'));
    await tester.enterText(passwordField, '123');
    final loginButton = find.byKey(Key('loginButton'));
    await tester.tap(loginButton);
    await tester.pump();
    expect(find.text('A senha é muito curta'), findsOneWidget);
  });

  testWidgets('Deve exibir erros quando e-mail e senha estiverem vazios',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginPage()));
    final loginButton = find.byKey(Key('loginButton'));
    await tester.tap(loginButton);
    await tester.pump();
    expect(find.text('Por favor insira seu e-mail'), findsOneWidget);
    expect(find.text('Por favor insira sua senha'), findsOneWidget);
  });

  testWidgets('Deve alternar visibilidade da senha',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginPage()));
    final togglePasswordVisibilityButton =
        find.byKey(Key('togglePasswordVisibility'));
    expect(find.byType(Icon, skipOffstage: false),
        findsOneWidget); // Verificar ícone
    await tester.tap(togglePasswordVisibilityButton);
    await tester.pump();
    // Verificar se o campo de senha agora está visível ou oculto
  });

  testWidgets('Deve mostrar erro para formato de e-mail inválido',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginPage()));
    await tester.enterText(find.byKey(Key('emailField')), 'emailinvalido');
    final loginButton = find.byKey(Key('loginButton'));
    await tester.tap(loginButton);
    await tester.pump();
    expect(find.text('Por favor, insira um e-mail válido'), findsOneWidget);
  });

  testWidgets(
      'Deve confirmar que o campo de email aparece na tela corretamente',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginPage()));

    final emailKey = find.byKey(Key('emailField'));

    expect(emailKey, findsOneWidget);
  });

  testWidgets(
      'Deve confirmar que o campo de senha aparece na tela corretamente',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginPage()));

    final passwordKey = find.byKey(Key('passwordField'));

    expect(passwordKey, findsOneWidget);
  });
}
