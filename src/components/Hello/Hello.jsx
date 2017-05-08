import React from 'react';
import PropTypes from 'prop-types';

import styles from './Hello.styl';
import moogle from './mini_moogle_by_morganedematons-d57jb7w.gif';

const Hello = ({ addressee }) => (
  <h2 className={styles.hello}>
    <img src={moogle} alt="sprite of a dancing moogle" /> Hello, {addressee}
  </h2>
);

Hello.propTypes = {
  addressee: PropTypes.string.isRequired,
};

export default Hello;
