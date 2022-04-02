import React, { useEffect, useState, Component } from 'react'
import * as ReactDOM from 'react-dom'
import ReactTable from "react-table-6";
import "react-table-6/react-table.css"
import axios from "axios"

class Index extends Component {
  constructor(props) {
    super(props);
    this.state = {
      recipes: [],
    };
  }

  loadRecipes() {
    axios
      .get('internal_api/recipes')
      .then((res) => {
        this.setState({ recipes: res.data });
      })
      .catch((error) => console.log(error));
  }

  componentDidMount() {
    this.loadRecipes();
  }

  render() {
     const columns = [{
       Header: 'Title',
       accessor: 'title'
       },{
       Header: 'Ratings',
       accessor: 'ratings'
       },{
       Header: 'Prep time',
       accessor: 'prep_time_minutes'
       },{
       Header: 'Cook time',
       accessor: 'cook_time_minutes'
       },{
       Header: 'Ingredients',
       accessor: 'ingredients'
       },{
       Header: 'Author',
       accessor: 'author_id'
       },{
       Header: 'Category',
       accessor: 'category_id'
    }]

    return (
          <div>
              <ReactTable
                  data={this.state.recipes}
                  columns={columns}
                  defaultPageSize = {10}
                  pageSizeOptions = {[10]}
              />
          </div>
    )
  }
}
export default Index;
