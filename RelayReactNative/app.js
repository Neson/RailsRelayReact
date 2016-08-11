/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import Relay, {
  DefaultNetworkLayer
} from 'react-relay';

Relay.injectNetworkLayer(
  new DefaultNetworkLayer('http://localhost:3000/graphql')
);

import PostsIndexContainer from 'containers/PostsIndexContainer';

export default class App extends Component {
  render() {
    return (
      <PostsIndexContainer/>
    );
  }
}
