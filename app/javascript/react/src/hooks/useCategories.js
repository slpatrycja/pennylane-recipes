import * as React from 'react';
import axios from 'axios';

function useCategories() {
  const [categories, setCategories] = React.useState([]);

  React.useEffect(() => {
    axios
      .get('internal_api/categories')
      .then((res) => {
        setCategories(res.data);
      })
  }, []);

  return categories;
}

export default useCategories;
