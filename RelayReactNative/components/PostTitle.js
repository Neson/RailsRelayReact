/**
 * @providesModule components/PostTitle
 */

import React, { Component } from 'react';
import Relay from 'react-relay';
import {
  StyleSheet,
  View,
  Text,
  TouchableOpacity
} from 'react-native';

class PostTitle extends Component {
  render() {
    let { post, onPress } = this.props;

    return (
      <TouchableOpacity
        activeOpacity={onPress ? 0.2 : 1}
        onPress={onPress}
      >
        <View style={styles.title}>
          <Text style={styles.titleText}>{post.subject}</Text>
        </View>
      </TouchableOpacity>
    );
  }
}

export default Relay.createContainer(PostTitle, {
  fragments: {
    post: () => Relay.QL`
      fragment on Post {
        subject
      }
    `
  }
});

const styles = StyleSheet.create({
  title: {
    marginVertical: 5,
    marginHorizontal: 2,
    borderLeftWidth: 8,
    borderLeftColor: '#000',
    height: 22,
    paddingHorizontal: 7,
    justifyContent: 'center'
  },
  titleText: {
    fontSize: 18
  }
});
