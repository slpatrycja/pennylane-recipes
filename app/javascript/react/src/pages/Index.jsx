import * as React from 'react';
import useRecipes from '../hooks/useRecipes';
import useCategories from '../hooks/useCategories';
import Table from '../components/Table'
import Searchbar from '../components/Searchbar'
import SelectDropdown from '../components/SelectDropdown'
import '../assets/Index.css';

function Index() {
  const [query, setQuery] = React.useState('');
  const [categoryId, setCategoryId] = React.useState(null);
  const [recipes, isError, isLoading] = useRecipes([query, categoryId]);
  const categories = useCategories();

  const currentCategory = () => {
    const found = categories.find(category => category[0] === categoryId);

    return found ? found[1] : null;
  }

  return (
    <div className="main-container">
      <h1>Pennylane Recipes</h1>

      <div className="filters-wrapper">
        <Searchbar query={query} handleSearch={(e) => setQuery(e.target.value)} />
        <SelectDropdown options={categories} value={currentCategory()} placeholder="Filter by category" onChange={(e) => setCategoryId(e.value)} onClear={() => setCategoryId(null)}/>
      </div>
      <Table recipes={recipes} isLoading={isLoading} isError={isError} />
    </div>
  );
}

export default Index;
