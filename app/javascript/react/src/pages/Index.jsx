import React, { useEffect, useState, Component } from 'react'
import axios from 'axios'
import Table from '../components/Table'
import Searchbar from '../components/Searchbar'
import '../assets/Index.css';

class Index extends Component {
  constructor(props) {
    super(props);
    this.state = {
      recipes: [],
      query: null,
    };

    this.loadRecipes = this.loadRecipes.bind(this);
    this.handleSearch = this.handleSearch.bind(this);
  }

  loadRecipes() {
    axios
      .get('internal_api/recipes', { params: { query: this.state.query?.split(',')  } } )
      .then((res) => {
        this.setState({ recipes: res.data });
      })
      .catch((error) => console.log(error));
   }

  handleSearch (e) {
    this.setState({ query: e.target.value })
  }

  componentDidMount() {
    this.loadRecipes();
  }

  render() {
    return (
          <div className="main-container">
            <h1>Pennylane Recipes</h1>
            <Searchbar onSearch={this.loadRecipes} query={this.state.query} handleSearch={this.handleSearch}/>
            <Table recipes={this.state.recipes} />
          </div>
    )
  }
}
export default Index;
