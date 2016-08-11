/**
 * @providesModule containers/PostContainer
 */

import React, { Component } from 'react';
import Relay from 'react-relay';

import Post from 'components/Post';
import PostRoute from 'routes/PostRoute';

export default class PostContainer extends Component {
  render() {
    let { postID, navigator } = this.props;

    return (
      <Relay.RootContainer
        Component={Post}
        route={new PostRoute({ postID })}
        renderFetched={data =>
          <Post
            {...data}
            onBackPress={() => navigator.pop()}
          />
        }
      />
    );
  }
}
