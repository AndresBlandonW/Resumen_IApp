import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:resume_iapp/provider/chatsProvider.dart' as globals;
import 'package:resume_iapp/secret.dart';

GptResponse gptResponseFromJson(String str) => GptResponse.fromJson(json.decode(str));

String gptResponseToJson(GptResponse data) => json.encode(data.toJson());

class GptResponse {
    GptResponse({
        required this.id,
        required this.object,
        required this.created,
        required this.model,
        required this.usage,
        required this.choices,
    });

    String id;
    String object;
    int created;
    String model;
    Usage usage;
    List<Choice> choices;

    factory GptResponse.fromJson(Map<String, dynamic> json) => GptResponse(
        id: json["id"],
        object: json["object"],
        created: json["created"],
        model: json["model"],
        usage: Usage.fromJson(json["usage"]),
        choices: List<Choice>.from(json["choices"].map((x) => Choice.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "object": object,
        "created": created,
        "model": model,
        "usage": usage.toJson(),
        "choices": List<dynamic>.from(choices.map((x) => x.toJson())),
    };
}

class Choice {
    Choice({
        required this.message,
        required this.finishReason,
        required this.index,
    });

    Message message;
    String finishReason;
    int index;

    factory Choice.fromJson(Map<String, dynamic> json) => Choice(
        message: Message.fromJson(json["message"]),
        finishReason: json["finish_reason"],
        index: json["index"],
    );

    Map<String, dynamic> toJson() => {
        "message": message.toJson(),
        "finish_reason": finishReason,
        "index": index,
    };
}

class Message {
    Message({
        required this.role,
        required this.content,
    });

    String role;
    String content;

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        role: json["role"],
        content: json["content"],
    );

    Map<String, dynamic> toJson() => {
        "role": role,
        "content": content,
    };
}

class Usage {
    Usage({
        required this.promptTokens,
        required this.completionTokens,
        required this.totalTokens,
    });

    int promptTokens;
    int completionTokens;
    int totalTokens;

    factory Usage.fromJson(Map<String, dynamic> json) => Usage(
        promptTokens: json["prompt_tokens"],
        completionTokens: json["completion_tokens"],
        totalTokens: json["total_tokens"],
    );

    Map<String, dynamic> toJson() => {
        "prompt_tokens": promptTokens,
        "completion_tokens": completionTokens,
        "total_tokens": totalTokens,
    };
}

class GptService {
  Future<GptResponse> getGptResponse(String book) async {
    List conversations = globals.ChatAsks.conversations;
    String auth = 'Bearer $openIA_KEY';
    final headers = {HttpHeaders.contentTypeHeader: 'application/json', 'Authorization': auth};
    final body = {"model": "gpt-3.5-turbo", "messages": conversations, "temperature": 0.7 };
    final regbody = json.encode(body);
    final response = await post(Uri.parse('https://api.openai.com/v1/chat/completions'), headers: headers, body: regbody);
    final gpt = gptResponseFromJson(utf8.decode(response.bodyBytes));
    return gpt;
  }
}