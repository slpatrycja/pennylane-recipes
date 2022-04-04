import React from 'react';
import ReactTable from 'react-table-6';
import 'react-table-6/react-table.css'
import '../assets/Table.css';

function Table({ recipes, isLoading, isError }) {
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
     style: { 'whiteSpace': 'break-spaces' },
     Cell: ({ row, value: cell }) => {
       return cell.join("\r\n");
      }
     },{
     id: 'author',
     Header: 'Author',
     accessor: 'author'
     },{
     id: 'category',
     Header: 'Category',
     accessor: 'category'
     },{
     id: 'image',
     Header: 'Image',
     accessor: 'image_url',
     Cell: ({ row, value: cell }) => {
       return <img className='recipe-img' src={cell} />;
     },
     style: { 'display': 'flex', 'flexDirection': 'column', 'justifyContent': 'center', 'alignItems': 'center' },
   }]

  const loadingText = 'Loading...'
  const tableText = isError ? 'Recipes are currently unavailable. Please try again later.'
    : 'There are no recipes for selected filters.'

  return (
    <div className="recipes-table">
      <ReactTable
          data={recipes}
          columns={columns}
          loading={isLoading}
          loadingText={loadingText}
          noDataText={tableText}
          defaultPageSize = {10}
          pageSizeOptions = {[10]}
      />
    </div>
  );
}

export default Table;
