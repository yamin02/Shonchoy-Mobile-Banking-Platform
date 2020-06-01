const mongoose = require('mongoose')

const clientSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true,
    },
    primaryGuardian: {
        type: String,
        required: true
    },
    motherName: {
        type: String,
        required: true,
    },
    NID: {
        required: true,
        unique: true
    },
    /*
    profileImage: {
        type: Buffer
    },
    */
    dob: {
        required: true,
        type: Date,
    },
    address: {
        required: true,
        type: String,
    },
    thana: {
        required: true,
        type: String,
    },
    city: {
        required: true,
        type: String,
    },
    district: {
        required: true,
        type: String,
    },
    postOffice: {
        required: true,
        type: String,
    },
    postalCode: {
        required: true,
        type: String,
    },
    createdAt: {
        type: Boolean,
        default: Date.now()
    }
})

const Client = mongoose.model('Client', clientSchema)

module.exports = Client