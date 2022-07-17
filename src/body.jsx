import React from 'react'
import {Container , Box , TextField , Button} from "@mui/material"

function Body() {
  return (
    <Container maxWidth="xl" className='lg:container w-auto mt-20 pt-10 border-black border-2 h-96'> 
      <form>
        <label className='text-lg  text-black '> Account name  </label>
        <TextField className='mt-4 ' id="outlined-basic" label="Account_name" variant="outlined" /><br></br><br></br>

        <Button className='' variant="contained" ><input type="submit" value="Create" /></Button>
        </form>
    </Container>
  )
}

export default Body