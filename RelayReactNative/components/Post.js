/**
 * @providesModule components/Post
 */

import React, { Component } from 'react';
import Relay from 'react-relay';
import {
  StyleSheet,
  ScrollView,
  View,
  TouchableOpacity,
  Text
} from 'react-native';

import PostTitle from 'components/PostTitle';

class Post extends Component {
  render() {
    let { post, onBackPress } = this.props;

    return (
      <ScrollView style={styles.container}>
        <PostTitle post={post} />
        <Text style={styles.content}>{post.content}</Text>
        <View style={styles.actions}>
          <TouchableOpacity onPress={onBackPress}>
            <Text style={styles.actionText}>Back</Text>
          </TouchableOpacity>
        </View>
      </ScrollView>
    );
  }
}

export default Relay.createContainer(Post, {
  fragments: {
    post: () => Relay.QL`
      fragment on Post {
        content,
        ${PostTitle.getFragment('post')}
      }
    `
  }
});

const styles = StyleSheet.create({
  container: {
    paddingVertical: 32,
    paddingHorizontal: 24,
    backgroundColor: '#FFF'
  },
  content: {
    marginVertical: 8,
    paddingHorizontal: 2
  },
  actions: {},
  actionText: {
    textDecorationLine: 'underline'
  }
});
