import axios from 'axios'

export const AXIOS = axios.create({
  baseURL: 'https://78xsb883zk.execute-api.us-east-1.amazonaws.com/default/',
  //baseURL: 'http://ec2-3-92-136-160.compute-1.amazonaws.com:8081',
    responseType: 'json'
});
