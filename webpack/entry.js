import React, { Component } from 'react';
import {render} from 'react-dom';
import UrlDecode from './components/UrlDecode';

class App extends Component {
  render() {
    return (
      <UrlDecode />
    )
  }
}

render(<App />, document.getElementById('root'));
