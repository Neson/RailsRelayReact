/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import Relay, {
  DefaultNetworkLayer
} from 'react-relay';
import { Navigator } from 'react-native';

Relay.injectNetworkLayer(
  new DefaultNetworkLayer('http://localhost:3000/graphql')
);

import PostsIndexContainer from 'containers/PostsIndexContainer';
import PostContainer from 'containers/PostContainer';

export default class App extends Component {
  render() {
    return (
      <Navigator
        initialRoute={{ name: 'posts' }}
        renderScene={(route, navigator) => {
          switch (route.name) {
          case 'posts':
            return (
              <PostsIndexContainer
                navigator={navigator}
              />
            );
          case 'post':
            return (
              <PostContainer
                postID={route.postID}
                navigator={navigator}
              />
            );
          }
        }}
      />
    );
  }
}
