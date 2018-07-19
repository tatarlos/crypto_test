class CreateCrpytoInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :crpyto_infos do |t|
      t.string :ticker
      t.datetime :date

      t.timestamps
    end
  end
end
