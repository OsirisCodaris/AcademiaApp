class Config {
  String Url = "http://app.academiagabon.ga/v1/";
  String urlFinal;

  Config(url) {
    this.urlFinal = this.Url + url;
  }
}
