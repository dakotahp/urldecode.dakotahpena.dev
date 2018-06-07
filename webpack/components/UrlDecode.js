import React, { Component } from 'react';

class UrlDecode extends Component {

  constructor(props) {
    super(props);
    this.state = {
      method: "decode",
      url: "",
    };
  }

  decodeUrl(event) {
    this.setState({url: event.target.value});
  }

  changeMethod(event) {
    console.log(event.target.dataset)
    this.setState({method: event.target.dataset.method});
  }

  render() {
    var decodeClass = ""
    var encodeClass = ""

    if(this.state.method == "encode") {
      var outputUrl = Url.encode(this.state.url);
      encodeClass = "active";
    } else {
      var outputUrl = Url.decode(this.state.url)
      decodeClass = "active";
    }

    return (
      <div>
        <section className="row">
          <div className="method-select">
            <a
              href="#decode"
              className={`button ${decodeClass}`}
              onClick={this.changeMethod.bind(this)}
              data-method="decode">
              Decode
            </a>
            <span> or </span>
            <a
              href="#encode"
              className={`button ${encodeClass}`}
              onClick={this.changeMethod.bind(this)}
              data-method="encode">
              Encode
            </a>
          </div>
        </section>

        <section role="io-view" className="row">
          <input
            value={this.state.url}
            type="url"
            placeholder="Input URL"
            autoFocus="autoFocus"
            className="input-url"
            onChange={this.decodeUrl.bind(this)} />

          <input value={outputUrl} type="url" placeholder="Output URL" className="output-url" />
        </section>
      </div>
    )
  }
}

export default UrlDecode;
