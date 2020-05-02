const XMLHttpRequest = require('xmlhttprequest').XMLHttpRequest;
// const request = require('request');
const customLog = require("../utils/customLog");

const getSignedAwsRequest = (filename) => {
  console.log("ALL SYSTEMS GO", filename);
  // console.log("ALL SYSTEMS GO", fileType);
  // return;
  // request(`/sign-s3?file-name=${filename}&file-type=text/html`, function(err, res, body) {
  //     console.log("HERE BE TREASURE", body);
  // });

  const xhr = new XMLHttpRequest();
  xhr.open('GET', `/sign-s3?file-name=${filename}&file-type=text/html`);
  xhr.onreadystatechange = () => {
    if(xhr.readyState === 4){
      if(xhr.status === 200){
        console.log("ALL SYSTEMS GO");
        // return;
        const response = JSON.parse(xhr.responseText);
        console.log(response);
        uploadFile(file, response.signedRequest);
        console.log("Blog post is ready to upload to AWS");
      }
      else{
        console.log('Could not get signed URL.');
      }
    }
  };
  xhr.send();
}

const uploadFile = (file, signedRequest) => {
  return new Promise((resolve, reject) => {
    const xhr = new XMLHttpRequest();
    xhr.open('PUT', signedRequest);
    xhr.onreadystatechange = () => {
      if(xhr.readyState === 4){
        if(xhr.status === 200){
            customLog("Blog post successfully uploaded to AWS", 'success');
        }
        else {
          customLog('Could not upload blog post to AWS.', 'error');
          reject(new Error(`There was a problem uploading the post to AWS. The response code was ${xhr.status}`));
        }
      }
    };
    xhr.send(file);
    resolve();
  })
}

module.exports = {
  getSignedAwsRequest,
  uploadFile
};
