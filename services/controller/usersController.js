const user =require ("../models/userModel")
const bcrypt =require ("bcryptjs")
const jwt =require ("jsonwebtoken")


module.exports ={
getAll:(req,res)=>{
    user.get((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    })
},

//======================================

adduser:(req,res)=> {

  const salt = bcrypt.genSaltSync(10)
  const hash = bcrypt.hashSync(req.body.password, salt)

  const {
    name,
    email,
    password,
    phone,
    image
  } = req.body;

  user.register((err, rslt) => {
    if (err) {
      res.status(500).send(err);
    } else {
      res.status(200).json(rslt);
    }
  }, name, email, hash, phone, image);
},

//================================
//   updateUser:(req,res)=>{
//     const {
        
//         name,
//         email,
//         password,
//         phone,
//         image
//       } = req.body;
//     user.update((err,result)=>{
//         if (err) res.status(500).send(err)
//         else res.status(200).json(result)
//     },req.params.id,name, email, password, phone, image)
// },
updateUser: (req, res) => {
  const userId = req.params.id;
  const { name, email, password, phone, image } = req.body;
  const userData = {};

  // Add the fields you want to update to the userData object
  if (name) {
    userData.name = name;
  }
  if (email) {
    userData.email = email;
  }
  if (password) {
    userData.password = password;
  }
  if (phone) {
    userData.phone = phone;
  }
  if (image) {
    userData.image = image;
  }

  user.update((err, result) => {
    if (err) {
      res.status(500).send(err.message);
    } else {
      res.status(200).json(result);
    }
  }, userId, userData);
},


  
//======================================================


getOne:(req, res)=>{
  let responseSent = false;

  user.login(req.body.email,req.body.password).then((user) => {
      if (!user) {
          responseSent = true;
          return res.status(500).send("User not found");
      }
      return new Promise((resolve, reject) => {
          bcrypt.compare(req.body.password, user.password, (error, isMatch) => {
              if (error) {
                  reject(error);
              }
              else if (!isMatch) {
                  reject("Invalid password");
              }
              else {
                  resolve(user);
              }
          });
      });
  })
  .then((user) => {
      const token = jwt.sign({ id: user.id }, "secret", { expiresIn: "1h" });

      if (!responseSent) {
          res.json({ token: token, user: user });
      }
  })
  .catch((error) => {
      if (!responseSent) {
          res.status(401).send(error);
      }
  });
},






//=======================================
deleteUser:(req,res)=>{
    user.delete((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    },req.params.id)
},

}