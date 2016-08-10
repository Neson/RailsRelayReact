/**
 * @providesModule components/PostTitle
 */

import React, { Component } from 'react';
import Relay from 'react-relay';
import {
  View,
  Text
} from 'react-native';

class PostTitle extends Component {
  render() {
    let { post } = this.props;

    return (
      <View>
        <Text>{post.subject}</Text>
      </View>
    );
  }
}

module.exports = Relay.createContainer(PostTitle, {
  fragments: {
    post: () => Relay.QL`
      fragment on Post {
        subject
      }
    `
  }
});
