import React, { useEffect, useState, Component } from 'react'
import ReactTable from 'react-table-6';
import 'react-table-6/react-table.css'
import '../assets/Table.css';

class Index extends Component {
  render() {
     const columns = [{
       id: 'title',
       Header: 'Title',
       accessor: 'title',
       style: { 'whiteSpace': 'unset' },
       },{
       id: 'ratings',
       Header: 'Ratings',
       accessor: 'ratings',
       style: { 'textAlign': 'center' },
       },{
       id: 'prepTime',
       Header: 'Prep time',
       accessor: 'prep_time_minutes',
       style: { 'textAlign': 'center' },
       },{
       id: 'cookTime',
       Header: 'Cook time',
       accessor: 'cook_time_minutes',
       style: { 'textAlign': 'center' },
       },{
       id: 'ingredients',
       Header: 'Ingredients',
       accessor: 'ingredients',
       width: 450,
       style: { 'whiteSpace': 'unset' },
       },{
       id: 'author',
       Header: 'Author',
       accessor: 'author_id'
       },{
       id: 'category',
       Header: 'Category',
       accessor: 'category_id'
    }]

    return (
          <div className="recipes-table">
              <ReactTable
                  data={this.props.recipes}
                  columns={columns}
                  defaultPageSize = {10}
                  pageSizeOptions = {[10]}
              />
          </div>
    )
  }
}
export default Index;
