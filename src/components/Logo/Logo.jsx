import React from 'react';
import PropTypes from 'prop-types';

import styles from './Logo.styl';

const Logo = ({ text }) => (
  <div className={styles.logo}>{ text }</div>
);

Logo.propTypes = {
  text: PropTypes.string.isRequired,
};

export default Logo;
