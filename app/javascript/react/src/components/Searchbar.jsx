import React, { Component } from 'react'
import '../assets/Searchbar.css';

class Searchbar extends Component {
  render () {
    return (
      <div className='searchbar-container'>
        <form onSubmit={e => e.preventDefault()} className="form-inline">
          <input
            type='text'
            size='45'
            class="form-control"
            placeholder='Search by ingredients (separated by comma)'
            onChange={this.props.handleSearch}
            value={this.props.query} />
          <button
            type='submit'
            class="btn btn-primary"
            onClick={this.props.onSearch}>
            Search
          </button>
        </form>
      </div>
    )
  }
}

export default Searchbar;
