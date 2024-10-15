Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.237.72.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6E01DB366
	for <netfs@lists.linux.dev>; Tue, 15 Oct 2024 09:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.237.72.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728984305; cv=none; b=gjsDWZUrziQMteA1f9E5/R4zurjmv/MfdhWEW4Sccw7l6/hOEwCGx4mjqfGd/DM95fu8TnGmamzcBkIPS+1d7naOHAt2kVag1Reeq1BvgouSCR4jUJCyfjv0cpds9gKmyNNKJSbDwtgpzI3da3qEiYLolgkuOgxO8su74Cqd9jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728984305; c=relaxed/simple;
	bh=rxLKrS7w7zyUKYbg5SX26OFOZE9TL/dqWvHJIVhx6Is=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bzWoz9x79jt7a6P1e4el/UCt7IbPKRZ7YCTjhGLnXLA0q/6IxtO8xUUwkirb1K0PXn6sYVgLSjhwYEPIMmvDltRT8lpUpuMEfA5OqdXJYLY31aIywpsLcZi8PDmsU3WZkR6f4LiWRm+T3FrP94K7myWJTCk6vb92ri290KsU0YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=52.237.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.52])
	by app1 (Coremail) with SMTP id HgEQrABXuG23NA5ntUrJBw--.1007S2;
	Tue, 15 Oct 2024 17:24:07 +0800 (CST)
Received: from pride-PowerEdge-R740.. (unknown [222.20.126.129])
	by gateway (Coremail) with SMTP id _____wDX34+1NA5nRCI5AA--.24175S2;
	Tue, 15 Oct 2024 17:24:06 +0800 (CST)
From: Dongliang Mu <dzm91@hust.edu.cn>
To: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: hust-os-kernel-patches@googlegroups.com,
	Dongliang Mu <dzm91@hust.edu.cn>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs: fix a reference of a removed file
Date: Tue, 15 Oct 2024 17:23:55 +0800
Message-ID: <20241015092356.1526387-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HgEQrABXuG23NA5ntUrJBw--.1007S2
Authentication-Results: app1; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvdXoW7XF1xZFyrZw45WrW8XFWkWFg_yoW3JFX_JF
	yfJFs5XryDArs7JF18KFn8WF13Z3W0kFy8Xw13JwsIv347J395CFZ3X3s0yrsxXrs29rn5
	WFWkXrZxXFy7tjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbv8YjsxI4VWxJwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI
	8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vE
	x4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAaw2AFwI0_Jr
	v_JF1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF
	0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v26r
	4UJVWxJr1lYx0E74AGY7Cv6cx26r4fZr1UJr1lYx0Ec7CjxVAajcxG14v26r4UJVWxJr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxAIw2
	8IcVCjz48v1sIEY20_GFW3Jr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AK
	xVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU0X_-JUUUUU==
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/

Since 86b374d061ee ("netfs: Remove fs/netfs/io.c") removed
fs/netfs/io.c, we need to delete its reference in the documentation.

Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 Documentation/filesystems/netfs_library.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/filesystems/netfs_library.rst b/Documentation/filesystems/netfs_library.rst
index f0d2cb257bb8..73f0bfd7e903 100644
--- a/Documentation/filesystems/netfs_library.rst
+++ b/Documentation/filesystems/netfs_library.rst
@@ -592,4 +592,3 @@ API Function Reference
 
 .. kernel-doc:: include/linux/netfs.h
 .. kernel-doc:: fs/netfs/buffered_read.c
-.. kernel-doc:: fs/netfs/io.c
-- 
2.43.0

