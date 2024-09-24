// import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:marquei/src/login/presentation/widgets/input_decoration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AddService extends StatefulWidget {
  const AddService({super.key});

  @override
  State<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  final _formKey = GlobalKey<FormState>();
  String _nome = '';
  String _descricao = '';
  String _duracao = '30min'; // Valor padrão
  File? _foto;
  double _preco = 0.0;
  String _categoria = 'Cabelo';

  // Lista de durações disponíveis
  List<String> duracoes = ['30min', '45min', '1 hora', '1 hora e 30min'];
  List<String> categorias = ['Cabelo', 'Mãos', 'Pés', 'Maquiagem'];

  Future<void> _salvarServico() async {
  if (_formKey.currentState!.validate()) {
    _formKey.currentState!.save();

    // Carregar o token do SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print('token ::::: $token');

    if (token != null) {
      // Criar uma requisição multiparte para enviar os dados e a foto
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://api.marquei.pro/api/services/'),
      );

      // Adicionar cabeçalho de autorização
      request.headers['Authorization'] = 'Bearer $token'; // Certifique-se de que 'Bearer' é necessário

      // Adicionar os campos diretamente no corpo da requisição
      request.fields['name'] = _nome;
      request.fields['description'] = _descricao;
      request.fields['value'] = _preco.toString(); // Convertendo para string
      request.fields['duration'] = _duracao;
      request.fields['category'] = _categoria;

      // Adicionar a foto como arquivo binário se uma foto for selecionada
      if (_foto != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'photo', // Nome do campo de foto na API
            _foto!.path,
          ),
        );
      }

      // Enviar a requisição
      var response = await request.send();

      // Tratar a resposta
      if (response.statusCode == 201) {
        // Serviço criado com sucesso
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Serviço salvo com sucesso!')),
        );
      } else {
        // Erro ao salvar
        final responseString = await response.stream.bytesToString();
        print('Erro: ${response.reasonPhrase}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar o serviço: ${response.reasonPhrase}\n$responseString')),
        );
      }
    } else {
      print('Token de autenticação não encontrado.');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro: Token de autenticação não encontrado.')),
      );
    }
  }
}

  // Função para selecionar a imagem do dispositivo
  Future<void> _selecionarImagem() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _foto = File(pickedFile.path);
      }
    });
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Criar Serviço',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Text('Nome', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                decoration: getAuthenticationInputDecorationEmail(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome do serviço';
                  }
                  return null;
                },
                onSaved: (value) {
                  _nome = value!;
                },
              ),
              SizedBox(height: 20),
              Text('Selecionar categoria',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                decoration: getAuthenticationInputDecorationEmail(),
                value: _categoria,
                items: categorias.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _categoria = newValue!;
                  });
                },
                onSaved: (value) {
                  _duracao = value!;
                },
              ),
              SizedBox(height: 20),
              Text('Descrição', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                decoration: getAuthenticationInputDecorationEmail(),
                maxLines: 3,
                onSaved: (value) {
                  _descricao = value!;
                },
              ),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text('Duração do serviço',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text('Preço',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: <Widget>[
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: getAuthenticationInputDecorationEmail(),
                      value: _duracao,
                      items: duracoes.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _duracao = newValue!;
                        });
                      },
                      onSaved: (value) {
                        _duracao = value!;
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      decoration: getAuthenticationInputDecorationEmail(),
                      keyboardType: TextInputType.number,
                      onSaved: (value) {
                        _preco = double.tryParse(value!) ?? 0.0;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        const WidgetStatePropertyAll(Color(0xFF0053CC)),
                    foregroundColor: const WidgetStatePropertyAll(Colors.white),
                    minimumSize: const WidgetStatePropertyAll(
                      Size(400, 45),
                    ),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)))),
                onPressed: _selecionarImagem,
                child: Text('Adicionar foto do serviço'),
              ),
              SizedBox(height: 20),
              _foto != null
                  ? Container(
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Image.file(
                        _foto!, // Exibir a imagem selecionada
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(child: Text('Nenhuma imagem selecionada')),
                    ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Color(0xFF0053CC)),
              foregroundColor: WidgetStateProperty.all(Colors.white),
              minimumSize: WidgetStateProperty.all(
                Size(double.infinity, 50),
              ),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            onPressed: _salvarServico,
            child: Text('Criar Serviço'),
          ),
        ),
      ),
    );
  }
}
