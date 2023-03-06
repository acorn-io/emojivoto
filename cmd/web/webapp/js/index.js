import React from "react";
import ReactDOM from "react-dom/client";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import Vote from './components/Vote.jsx';
import Leaderboard from './components/Leaderboard.jsx';
import gridStyles from '../css/grid.css';
import styles from '../css/styles.css';

// Hey
export default function App() {
  return (
    <BrowserRouter>
      <div>
        <div className="main-content">
          <Routes>
            <Route exact path="/" element={<Vote/> } />
            <Route path="/leaderboard" element={ <Leaderboard/> } />
          </Routes>
        </div>
      </div>
    </BrowserRouter>
  );
}

const root = ReactDOM.createRoot(document.getElementById('main'));
root.render(<App />)