import React from 'react';

import Logo from './Logo/Logo';
import Hello from './Hello/Hello';

const App = () => (
  <div>
    <Logo text="Snaps!" />
    <Hello addressee="World" />
    <p>And some running body copy, <em>just in case</em>&trade;</p>
  </div>
);

export default App;
