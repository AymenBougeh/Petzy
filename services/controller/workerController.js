const worker =require ("../models/workerModel")
const bcrypt =require ("bcryptjs")
const jwt =require ("jsonwebtoken")

module.exports ={
getAll:(req,res)=>{
    worker.get((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    })
},
addWorker: (req, res) => {
  const {
    name,
    email,
    password,
    phone,
    image,
    status,
    license_number,
    years_of_experience,
    description,
    role,
    latitude,
    longitude,
    price,
    services,
    aboutPet,
    rating
  } = req.body;

  // Check if password is provided
  if (!password) {
    return res.status(400).json({ error: 'Password is required.' });
  }

  const salt = bcrypt.genSaltSync(10);
  const hash = bcrypt.hashSync(password, salt);

  const values = [
    name,
    email,
    hash,
    phone,
    image,
    status,
    license_number,
    years_of_experience,
    description,
    role,
    latitude,
    longitude,
    price,
    services, // Convert services array to a JSON string
    aboutPet,
    rating// Placeholder for rating, since it's not provided in the request body
  ];

  worker.register((err, rslt) => {
    if (err) {
      res.status(500).send(err);
    } else {
      console.log(req.body);
      res.status(200).json(rslt);
    }
  }, values);
},

updateWorker: (req, res) => {
  const workerId = req.params.id;
  const { description, aboutPet, services, price } = req.body;
  const workerData = {};

  if (description) {
    workerData.description = description;
  }
  if (aboutPet) {
    workerData.aboutPet = aboutPet;
  }
  if (services) {
    workerData.services = services;
  }
  if (price) {
    workerData.price = price;
  }

  worker.update((err, result) => {
    if (err) {
      res.status(500).send(err.message);
    } else {
      res.status(200).json(result);
    }
  }, workerId, workerData);
},

//   getOne:(req,res)=>{
//     worker.login((err,result)=>{
//         if (err) res.status(500).send(err)
//         else res.status(200).json(result)
//     },req.params.id)
// },


getOne:(req, res)=>{
  let responseSent = false;

  worker.login(req.body.email,req.body.password).then((worker) => {
      if (!worker) {
          responseSent = true;
          return res.status(500).send("worker not found");
      }
      return new Promise((resolve, reject) => {
          bcrypt.compare(req.body.password, worker.password, (error, isMatch) => {
              if (error) {
                  reject(error);
              }
              else if (!isMatch) {
                  reject("Invalid password");
              }
              else {
                  resolve(worker);
              }
          });
      });
  })
  .then((worker) => {
      const token = jwt.sign({ id: worker.id }, "secret", { expiresIn: "1h" });

      if (!responseSent) {
          res.json({ token: token, worker: worker });
      }
  })
  .catch((error) => {
      if (!responseSent) {
          res.status(401).send(error);
      }
  });
},


deleteWorker:(req,res)=>{
    worker.deletevet((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    },req.params.id)
},

}