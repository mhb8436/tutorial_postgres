db.inventory.insertMany([
   { item: "journal", qty: 25, size: { h: 14, w: 21, uom: "cm" }, status: "A" },
   { item: "notebook", qty: 50, size: { h: 8.5, w: 11, uom: "in" }, status: "A" },
   { item: "paper", qty: 100, size: { h: 8.5, w: 11, uom: "in" }, status: "D" },
   { item: "planner", qty: 75, size: { h: 22.85, w: 30, uom: "cm" }, status: "D" },
   { item: "postcard", qty: 45, size: { h: 10, w: 15.25, uom: "cm" }, status: "A" }
]);

# 컬렉션에서 모든 문서 선택
db.inventory.find( {} )

SELECT * FROM inventory

# 동등성 조건 지정
db.inventory.find( { status: "D" } )

SELECT * FROM inventory WHERE status = "D"


# 쿼리 연산자를 사용하여 조건 지정
db.inventory.find( { status: { $in: [ "A", "D" ] } } )

SELECT * FROM inventory WHERE status in ("A", "D")

# AND 조건 지정
db.inventory.find( { status: "A", qty: { $lt: 30 } } )

SELECT * FROM inventory WHERE status = "A" AND qty < 30

# OR 조건 지정
db.inventory.find( { $or: [ { status: "A" }, { qty: { $lt: 30 } } ] } )

SELECT * FROM inventory WHERE status = "A" OR qty < 30

# AND OR 조건 지정
db.inventory.find( {
     status: "A",
     $or: [ { qty: { $lt: 30 } }, { item: /^p/ } ]
} )

{
   status: 'A',
   $or: [
     { qty: { $lt: 30 } }, { item: { $regex: '^p' } }
   ]
}


db.inventory.insertMany( [
   { item: "journal", qty: 25, size: { h: 14, w: 21, uom: "cm" }, status: "A" },
   { item: "notebook", qty: 50, size: { h: 8.5, w: 11, uom: "in" }, status: "A" },
   { item: "paper", qty: 100, size: { h: 8.5, w: 11, uom: "in" }, status: "D" },
   { item: "planner", qty: 75, size: { h: 22.85, w: 30, uom: "cm" }, status: "D" },
   { item: "postcard", qty: 45, size: { h: 10, w: 15.25, uom: "cm" }, status: "A" }
]);

# 점 표기법이 있는 중첩 필드 쿼리
## 중첩된 필드에 동등성 항목 일치 지정
db.inventory.find( { "size.uom": "in" } )

## 쿼리 연산자를 사용하여 일치 지정
db.inventory.find( { "size.h": { $lt: 15 } } )

## AND 조건 지정
db.inventory.find( { "size.h": { $lt: 15 }, "size.uom": "in", status: "D" } )

db.inventory.find( { size: { h: 14, w: 21, uom: "cm" } } )



# 빼열 
db.inventory.insertMany([
   { item: "journal", qty: 25, tags: ["blank", "red"], dim_cm: [ 14, 21 ] },
   { item: "notebook", qty: 50, tags: ["red", "blank"], dim_cm: [ 14, 21 ] },
   { item: "paper", qty: 100, tags: ["red", "blank", "plain"], dim_cm: [ 14, 21 ] },
   { item: "planner", qty: 75, tags: ["blank", "red"], dim_cm: [ 22.85, 30 ] },
   { item: "postcard", qty: 45, tags: ["blue"], dim_cm: [ 10, 15.25 ] }
]);

# 배열 매치 
db.inventory.find( { tags: ["red", "blank"] } )
db.inventory.find( { tags: { $all: ["red", "blank"] } } )


# 요소에 대한 배열 쿼리 
db.inventory.find( { tags: "red" } )
db.inventory.find( { dim_cm: { $gt: 25 } } )

# 배열 요소에 복합 필터 조건을 사용하여 배열 쿼리하기
db.inventory.find( { dim_cm: { $gt: 15, $lt: 20 } } )

# 여러 기준을 충족하는 배열 요소 쿼리하기
db.inventory.find( { dim_cm: { $elemMatch: { $gt: 22, $lt: 30 } } } )

# 배열 인덱스 위치로 요소 쿼리하기
db.inventory.find( { "dim_cm.1": { $gt: 25 } } )

# 배열 길이로 배열 쿼리하기
db.inventory.find( { "tags": { $size: 3 } } )



# 임베디드 문서 배열 쿼리하기 
db.inventory.insertMany( [
   { item: "journal", instock: [ { warehouse: "A", qty: 5 }, { warehouse: "C", qty: 15 } ] },
   { item: "notebook", instock: [ { warehouse: "C", qty: 5 } ] },
   { item: "paper", instock: [ { warehouse: "A", qty: 60 }, { warehouse: "B", qty: 15 } ] },
   { item: "planner", instock: [ { warehouse: "A", qty: 40 }, { warehouse: "B", qty: 5 } ] },
   { item: "postcard", instock: [ { warehouse: "B", qty: 15 }, { warehouse: "C", qty: 35 } ] }
]);

## 배열에 중첩된 문서 쿼리
db.inventory.find( { "instock": { warehouse: "A", qty: 5 } } )

db.inventory.find( { "instock": { qty: 5, warehouse: "A" } } )


## 문서 배얼에 포함된 필드 쿼리 조건 지정
db.inventory.find( { 'instock.qty': { $lte: 20 } } )


## 배열 인덱스를 사용하여 포함된 문서 필드 쿼리하기
db.inventory.find( { 'instock.0.qty': { $lte: 20 } } )

## 문서 배열에 여러 조건 지정
db.inventory.find( { "instock": { $elemMatch: { qty: 5, warehouse: "A" } } } )

db.inventory.find( { "instock": { $elemMatch: { qty: { $gt: 10, $lte: 20 } } } } )

db.inventory.find( { "instock.qty": { $gt: 10,  $lte: 20 } } )

db.inventory.find( { "instock.qty": 5, "instock.warehouse": "A" } )


# 프로젝트 필드 

db.inventory.insertMany( [
  { item: "journal", status: "A", size: { h: 14, w: 21, uom: "cm" }, instock: [ { warehouse: "A", qty: 5 } ] },
  { item: "notebook", status: "A",  size: { h: 8.5, w: 11, uom: "in" }, instock: [ { warehouse: "C", qty: 5 } ] },
  { item: "paper", status: "D", size: { h: 8.5, w: 11, uom: "in" }, instock: [ { warehouse: "A", qty: 60 } ] },
  { item: "planner", status: "D", size: { h: 22.85, w: 30, uom: "cm" }, instock: [ { warehouse: "A", qty: 40 } ] },
  { item: "postcard", status: "A", size: { h: 10, w: 15.25, uom: "cm" }, instock: [ { warehouse: "B", qty: 15 }, { warehouse: "C", qty: 35 } ] }
]);

db.inventory.find( { status: "A" } )

SELECT * from inventory WHERE status = "A"


db.inventory.find( { status: "A" }, { item: 1, status: 1 } )

SELECT _id, item, status from inventory WHERE status = "A"

db.inventory.find( { status: "A" }, { item: 1, status: 1, _id: 0 } )

SELECT item, status from inventory WHERE status = "A"

db.inventory.find( { status: "A" }, { status: 0, instock: 0 } )

## 포함된 문서에서 특정 필드 반환
db.inventory.find(
   { status: "A" },
   { item: 1, status: 1, "size.uom": 1 }
)

# 포함된 문서에서 특정 필드 미표시
db.inventory.find(
   { status: "A" },
   { "size.uom": 0 }
)

# 배열에서 포함된 문서에 프로젝션
db.inventory.find( { status: "A" }, { item: 1, status: 1, "instock.qty": 1 } )


# 반환된 배열에 프로젝트별 배열 요소 프로젝션
db.inventory.find( { status: "A" }, { item: 1, status: 1, instock: { $slice: -1 } } )

# case 문 
db.inventory.find(
   { },
   {
      _id: 0,
      item: 1,
      status: {
         $switch: {
            branches: [
               {
                  case: { $eq: [ "$status", "A" ] },
                  then: "Available"
               },
               {
                  case: { $eq: [ "$status", "D" ] },
                  then: "Discontinued"
               },
            ],
            default: "No status found"
         }
      },
      area: {
         $concat: [
            { $toString: { $multiply: [ "$size.h", "$size.w" ] } },
            " ",
            "$size.uom"
         ]
      },
      reportNumber: { $literal: 1 }
   }
)


# null 필드 
db.inventory.insertMany([
   { _id: 1, item: null },
   { _id: 2 }
])

db.inventory.find( { item: null } )

db.inventory.find( { item: { $ne : null } } )

# 존재 확인 
db.inventory.find( { item : { $exists: false } } )
