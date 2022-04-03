import React, { useEffect, useState, Component } from 'react'
import Dropdown from 'react-dropdown';
import 'react-dropdown/style.css';
import '../assets/Dropdown.css';

class SelectDropdown extends Component {
  render() {
    const options = this.props.options.map((option) =>  { return { label: option[1], value: option[0] } });

    return (
      <Dropdown
        className="recipes-dropdown"
        options={options}
        value={this.props.value}
        placeholder={this.props.placeholder}
        onChange={this.props.onChange}
      />
    )
  }
}

export default SelectDropdown;
