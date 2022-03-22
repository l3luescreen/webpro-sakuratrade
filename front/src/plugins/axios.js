import axios from 'axios'

const instance = axios.create({
    baseURL: 'http://localhost:3000',
})

instance.interceptors.request.use(
    function (config) {
        const tokenStr = sessionStorage.getItem('state')
        const token = JSON.parse(tokenStr)
        if (token) {
            config.headers['authorization'] = token.token
        }
        return config;
    },
    function (error) {
        return Promise.reject(error);
    }
);

export default instance
