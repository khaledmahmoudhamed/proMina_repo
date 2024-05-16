class ProMina {
  List<Item>? item;

  ProMina({
    this.item,
  });

  ProMina.fromJson(Map<String, dynamic> json) {
    if (json['item'] != null) {
      item = <Item>[];
      json['item'].forEach((v) {
        item!.add(new Item.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.item != null) {
      data['item'] = this.item!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Item {
  String? name;
  Request? request;

  Item({
    this.name,
    this.request,
  });

  Item.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    request =
        json['request'] != null ? new Request.fromJson(json['request']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.request != null) {
      data['request'] = this.request!.toJson();
    }

    return data;
  }
}

class Request {
  String? method;
  Body? body;

  Request({
    this.method,
  });

  Request.fromJson(Map<String, dynamic> json) {
    method = json['method'];

    body = json['body'] != null ? new Body.fromJson(json['body']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['method'] = this.method;

    if (this.body != null) {
      data['body'] = this.body!.toJson();
    }

    return data;
  }
}

class Body {
  String? mode;
  List<Formdata>? formdata;

  Body({this.mode, this.formdata});

  Body.fromJson(Map<String, dynamic> json) {
    mode = json['mode'];
    if (json['formdata'] != null) {
      formdata = <Formdata>[];
      json['formdata'].forEach((v) {
        formdata!.add(new Formdata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mode'] = this.mode;
    if (this.formdata != null) {
      data['formdata'] = this.formdata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Formdata {
  String? key;
  String? value;
  String? type;
  String? src;

  Formdata({this.key, this.value, this.type, this.src});

  Formdata.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
    type = json['type'];
    src = json['src'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['value'] = this.value;
    data['type'] = this.type;
    data['src'] = this.src;
    return data;
  }
}
