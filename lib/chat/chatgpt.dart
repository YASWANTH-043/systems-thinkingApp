import 'dart:convert';
import 'constant.dart';
import 'package:flutter/material.dart';
import 'package:pool/chat/sample.dart';
import 'package:http/http.dart' as http;

class Chatgpt extends StatefulWidget {
  const Chatgpt({super.key});

  @override
  State<Chatgpt> createState() => _ChatgptState();
}

class _ChatgptState extends State<Chatgpt> {
  late bool isLoading;
  /*late String text;
  late String chatmessagetype;*/
  final TextEditingController _textController = TextEditingController();
  final _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  @override
  void initState() {
    super.initState();
    isLoading = false;
  }
  
Future<String> generateResponse(String prompt) async {
  const apikey = apiSecretKey;
  var url = Uri.https('api.openai.com', '/v1/completions');
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $apikey'
  };
  var body = jsonEncode({
    'model': 'text-davinci-003',
    'prompt': prompt,
    'max_token': 5000,
    'top_p': 1,
    'frequency_penalty': 0.0,
    'presence_penalty': 0.0,
  });
  var client = http.Client();

  try {
    final response = await client.post(url, headers: headers, body: body);

    // decode the response
    Map<String, dynamic> newresponse = jsonDecode(response.body);
    return newresponse['choices'][0]['text'];
  } finally {
    client.close();
  }
}

  /*Future<String> generateResponse(String prompt) async {
    const apikey = apiSecretKey;
    var url = Uri.https('api.openai.com', '/v1/completions');
    final response = await generateResponse(prompt); /*http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apikey'
        },*/
        body: jsonEncode({
          'model': 'text-davinci-003',
          'prompt': prompt,
          'max_token': 5000,
          'top_p': 1,
          'frequency_penalty': 0.0,
          'presence_penalty': 0.0,
        });

    //decode the response
    Map<String, dynamic> newresponse = jsonDecode(response.body);
    return newresponse['choices'][0]['text'];
  } */

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Food Guide',
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: Colors.grey[700],
      ),
      backgroundColor: Colors.grey[900],
      body: Column(
        children: [
          Expanded(
            child: _buildList(),
          ),
          Visibility(
              visible: isLoading,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // Input field
                _buildInput(),

                //submit button
                _buildSubmit(),
              ],
            ),
          )
        ],
      ),
    ));
  }

  Expanded _buildInput() {
    return Expanded(
        child: TextField(
      textCapitalization: TextCapitalization.sentences,
      style: const TextStyle(color: Colors.white),
      controller: _textController,
      decoration: const InputDecoration(
        fillColor: Colors.grey,
        filled: true,
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
    ));
  }

  Widget _buildSubmit() {
    return Visibility(
      visible: !isLoading,
      child: Container(
        color: Colors.grey,
        child: IconButton(
          icon: const Icon(Icons.send_rounded),
          color: Colors.grey[700],
          onPressed: () {
            // display user input
            setState(() {
              _messages.add(ChatMessage(
                  text: _textController.text,
                  chatMessageType: ChatMessageType.user));
              isLoading = true;
            });
            var input = _textController.text;
            _textController.clear();
            Future.delayed(const Duration(milliseconds: 50))
                .then((value) => _scrollDown());
            // call chatbot api
            generateResponse(input).then((value) {
              setState(() {
                isLoading = false;
                // display chatbot response
                _messages.add(ChatMessage(
                    text: value, chatMessageType: ChatMessageType.bot));
              });
            });
            _textController.clear();
            Future.delayed(const Duration(milliseconds: 25))
                .then((value) => _scrollDown());
          },
        ),
      ),
    );
  }

  void _scrollDown() {
    _scrollController.animateTo(10,
        duration: const Duration(milliseconds: 50), curve: Curves.easeOut);
  }

  ListView _buildList() {
    return ListView.builder(
        itemCount: _messages.length,
        controller: _scrollController,
        itemBuilder: ((context, index) {
          var message = _messages[index];
          return ChatMessageWidget(message.text, message.chatMessageType);
        }));
  }
}

class ChatMessageWidget extends StatelessWidget {
  final String text;
  final ChatMessageType chatMessageType;
  const ChatMessageWidget(
    this.text,
    this.chatMessageType, {super.key}
  );

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(16),
        color: chatMessageType == ChatMessageType.bot
            ? Colors.grey[700]
            : Colors.grey[900],
        child: Row(
          children: [
            chatMessageType == ChatMessageType.bot
                ? Container(
                    margin: const EdgeInsets.only(right: 16),
                    child: CircleAvatar(
                      backgroundColor: const Color.fromRGBO(16, 163, 127, 1),
                      child: Image.asset(
                        'assets/images/del1.png',
                        color: Colors.white,
                        scale: 1.5,
                      ),
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.only(right: 16),
                    child: const CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                  ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    )),
                    child: Text(
                      text,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.white),
                    ))
              ],
            ))
          ],
        ));
  }
}
