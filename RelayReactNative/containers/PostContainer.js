/**
 * @providesModule containers/PostContainer
 */

import React, { Component } from 'react';
import Relay from 'react-relay';

import Post from 'components/Post';
import PostRoute from 'routes/PostRoute';

export default class PostContainer extends Component {
  render() {
    return (
      <Relay.RootContainer
        Component={Post}
        route={new PostRoute({ postID: '1' })}
      />
    );
  }
}
