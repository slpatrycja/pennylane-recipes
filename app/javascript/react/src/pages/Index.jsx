import React, { useEffect, useState, Component } from 'react'
import axios from 'axios'
import Table from '../components/Table'
import Searchbar from '../components/Searchbar'
import SelectDropdown from '../components/SelectDropdown'
import '../assets/Index.css';

class Index extends Component {
  constructor(props) {
    super(props);
    this.state = {
      recipes: [],
      categories: [],
      query: null,
      categoryId: null,
      isLoading: false,
      error: false,
    };

    this.loadRecipes = this.loadRecipes.bind(this);
    this.handleSearch = this.handleSearch.bind(this);
    this.handleCategoryChange = this.handleCategoryChange.bind(this);
    this.selectedCategory = this.selectedCategory.bind(this);

  }

  async loadRecipes() {
    console.log(this.state.categoryId);
    this.setState({ isLoading: true });

    axios
      .get('internal_api/recipes', { params: { query: this.state.query?.split(','), category_id: this.state.categoryId } } )
      .then((res) => {
        this.setState({ recipes: res.data, isLoading: false });
      })
      .catch((_error) => this.setState({ isLoading: false, error: true }));
   }

  async loadCategories() {
    axios
      .get('internal_api/categories')
      .then((res) => {
        this.setState({ categories: res.data });
      })
      .catch((_error) => this.setState({ isLoading: false, error: true }));
   }

  handleSearch (e) {
    this.setState({ query: e.target.value })
  }

  async handleCategoryChange(e) {
    await this.setState({ categoryId: e.value });
    this.loadRecipes();
  }

  selectedCategory() {
    return this.state.categories.find(c => c.id === this.state.categoryId);
  }

  componentDidMount() {
    this.loadRecipes();
    this.loadCategories();
  }

  render() {
    return (
          <div className="main-container">
            <h1>Pennylane Recipes</h1>
            <div className="filters-wrapper">
              <Searchbar onSearch={this.loadRecipes} query={this.state.query} handleSearch={this.handleSearch}/>
              <SelectDropdown options={this.state.categories} value={this.selectedCategory()} placeholder="Filter by category" onChange={this.handleCategoryChange}/>
            </div>
            <Table recipes={this.state.recipes} isLoading={this.state.isLoading} error={this.state.error}/>
          </div>
    )
  }
}
export default Index;
