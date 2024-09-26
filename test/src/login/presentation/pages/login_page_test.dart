import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:marquei/src/home/presentation/pages/home_page.dart';
import 'package:marquei/src/login/presentation/pages/login_page.dart';

void main() {
  late LoginPageState loginPageState;

  setUp(() {
    loginPageState = LoginPageState();
  });

  bool validarEmail(String email) {
    // Regex simples para verificar o formato do email
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(email);
  }

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

  testWidgets('Empty email shows error message', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    // Find the email field and login button
    final emailField = find.byKey(const Key('emailField'));
    final loginButton = find.byKey(const Key('loginButton'));

    // Try to submit the form with an empty email
    await tester.tap(loginButton);
    await tester.pump();

    // Check if the error message appears
    expect(find.text('Por favor insira seu e-mail'), findsOneWidget);
  });

  test('Email validation returns error if email is empty', () {
    final result = loginPageState.emailRegExp.hasMatch('');
    expect(result, false);
  });

  test('Email validation returns error if email is invalid', () {
    final result = loginPageState.emailRegExp.hasMatch('invalidemail');
    expect(result, false);
  });

  test('Email validation passes if email is valid', () {
    final result = loginPageState.emailRegExp.hasMatch('test@example.com');
    expect(result, true);
  });

  testWidgets('Testando validação de email inválido',
      (WidgetTester tester) async {
    // Constrói a tela de login
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    // Localiza o campo de email
    final emailField = find.byKey(const Key('emailField'));
    final loginButton = find.byKey(const Key('loginButton'));

    // Verifica se o widget está na árvore
    expect(emailField, findsOneWidget);

    // Digita um email inválido
    await tester.enterText(emailField, 'emailinvalido');

    // Tenta fazer login
    await tester.tap(loginButton);
    await tester.pump(); // Atualiza a interface após o clique

    // Verifica se a mensagem de erro aparece
    expect(find.text('Por favor, insira um e-mail válido'), findsOneWidget);
  });

  testWidgets('Testando validação de senha curta', (WidgetTester tester) async {
    // Constrói a tela de login
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    // Localiza o campo de senha
    final passwordField = find.byKey(const Key('passwordField'));
    final loginButton = find.byKey(const Key('loginButton'));

    // Verifica se o widget está na árvore
    expect(passwordField, findsOneWidget);

    // Digita uma senha curta
    await tester.enterText(passwordField, '123');

    // Tenta fazer login
    await tester.tap(loginButton);
    await tester.pump(); // Atualiza a interface após o clique

    // Verifica se a mensagem de erro aparece
    expect(find.text('A senha é muito curta'), findsOneWidget);
  });

  testWidgets('Testando validação de email e senha válidos',
      (WidgetTester tester) async {
    // Constrói a tela de login
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    // Localiza os campos de email e senha
    final emailField = find.byKey(const Key('emailField'));
    final passwordField = find.byKey(const Key('passwordField'));
    final loginButton = find.byKey(const Key('loginButton'));

    // Digita um email e senha válidos
    await tester.enterText(emailField, 'teste@email.com');
    await tester.enterText(passwordField, 'senha1234');

    // Tenta fazer login
    await tester.tap(loginButton);
    await tester.pump(); // Atualiza a interface após o clique

    // Verifica se as mensagens de erro não aparecem
    expect(find.text('Por favor, insira um e-mail válido'), findsNothing);
    expect(find.text('A senha é muito curta'), findsNothing);
  });

  test('Deve retornar false para email vazio', () {
    final resultado = validarEmail('');
    expect(resultado, false);
  });

  test('Deve retornar false para email inválido', () {
    final resultado = validarEmail('emailinvalido');
    expect(resultado, false);
  });

  
}
