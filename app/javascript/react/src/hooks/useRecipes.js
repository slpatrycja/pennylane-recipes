import * as React from 'react';
import axios from 'axios';

function useRecipes(dependencies) {
  const [recipes, setRecipes] = React.useState([]);
  const [isError, setIsError] = React.useState(false);
  const [isLoading, setIsLoading] = React.useState(true);
  const [query, categoryId] = dependencies;

  React.useEffect(() => {
    axios
      .get('internal_api/recipes', { params: { query: query?.split(','), category_id: categoryId } } )
      .then((res) => {
        setRecipes(res.data);
      })
      .catch(() => setIsError(true))
      .finally(() => setIsLoading(false));
  }, [...dependencies]);

  return [recipes, isError, isLoading];
}

export default useRecipes;
