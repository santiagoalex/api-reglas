'use strict';
module.exports = (sequelize, DataTypes) => {
  const ProductoRegla = sequelize.define('ProductoRegla', {
    id: { 
      type:DataTypes.SMALLINT,
      allowNull: false,
      autoIncrement: true,
      primaryKey: true
    },
    valor: DataTypes.STRING(100),
    estado: DataTypes.DECIMAL(2, 0)
  }, {
    timestamps: false,
    underscored: true,
    freezeTableName: true,
    tableName: 'tbl_ace_productos_regla'
  });
  ProductoRegla.associate = function(models) {
    // associations can be defined here
    ProductoRegla.belongsTo(models.Regla);
    ProductoRegla.belongsTo(models.TipoProducto);
  };
  return ProductoRegla;
};