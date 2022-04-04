import React from 'react';
import Dropdown from 'react-dropdown';
import 'react-dropdown/style.css';
import '../assets/Dropdown.css';

function SelectDropdown({ options, value, placeholder, onChange, onClear }) {
  const mappedOptions = options.map((option) =>  { return { label: option[1], value: option[0] } });

  return (
    <>
      <Dropdown
        className="recipes-dropdown"
        options={mappedOptions}
        value={value}
        placeholder={placeholder}
        onChange={onChange}
      />
      <button
        className="btn btn-primary"
        onClick={onClear}>
        Clear
      </button>
    </>
  );
}

export default SelectDropdown;
