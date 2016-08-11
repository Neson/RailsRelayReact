/**
 * @providesModule containers/PostsIndexContainer
 */

import React, { Component } from 'react';
import Relay from 'react-relay';

import PostsIndex from 'components/PostsIndex';
import PostsIndexRoute from 'routes/PostsIndexRoute';

export default class PostsIndexContainer extends Component {
  render() {
    let { navigator } = this.props;

    return (
      <Relay.RootContainer
        Component={PostsIndex}
        route={new PostsIndexRoute()}
        renderFetched={data =>
          <PostsIndex
            {...data}
            onPostPress={postID => navigator.push({ name: 'post', postID })}
          />
        }
      />
    );
  }
}
