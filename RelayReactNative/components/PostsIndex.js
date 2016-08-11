/**
 * @providesModule components/PostsIndex
 */

import React, { Component } from 'react';
import Relay from 'react-relay';
import {
  StyleSheet,
  ScrollView,
  Text
} from 'react-native';

import PostTitle from 'components/PostTitle';

class PostsIndex extends Component {
  render() {
    let { edges: postEdges } = this.props.posts;

    return (
      <ScrollView style={styles.container}>
        <Text style={styles.title}>Listing Posts</Text>
        {(() => {
          return postEdges.map(edge => <PostTitle post={edge.node} key={edge.__dataID__} />);
        })()}
      </ScrollView>
    );
  }
}

export default Relay.createContainer(PostsIndex, {
  fragments: {
    posts: () => Relay.QL`
      fragment on PostConnection {
        edges {
          node {
            ${PostTitle.getFragment('post')}
          }
        }
      }
    `
  }
});

const styles = StyleSheet.create({
  container: {
    paddingVertical: 32,
    paddingHorizontal: 24
  },
  title: {
    fontSize: 32,
    marginVertical: 4
  }
});
