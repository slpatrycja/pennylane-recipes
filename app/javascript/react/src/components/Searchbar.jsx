import React, { Component } from 'react'
import '../assets/Searchbar.css';

function Searchbar({ ingredients, handleSearch }) {
  return (
    <div className='searchbar-container'>
      <form onSubmit={e => e.preventDefault()} className="form-inline">
        <input
          type='text'
          size='45'
          className="form-control"
          placeholder='Search by ingredients (separated by comma)'
          onChange={handleSearch}
          value={ingredients} />
      </form>
    </div>
  )
}

export default Searchbar;
