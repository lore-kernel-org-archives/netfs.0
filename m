Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072D8611A
	for <netfs@lists.linux.dev>; Sat, 23 Mar 2024 09:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711186250; cv=none; b=sJ5mISv+MbGjbLZ13SqwRAr2WW6lleojJdd6A5vPAQ4KNiMQ738ZR3NbBpz6Evoc4Vr60ObZDV+D3F3aUO4s5HT0nllf9idpqxyCn8WV79l0rHyYtSbse37kNuOagtWJhoThvJu0bdQyMnfDxMb7alkas6AP0JznWuub6zc+cvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711186250; c=relaxed/simple;
	bh=lLyw+W3Wu5j9LxVmGBPdDrxGgyjBpaROIerB7u4wGXY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mqQAauYFuo1bBmFk0V0AcZfEujYjiWoG9VjpWbw6Zy53Sq2iCcv11a/caQYVBgDE7iH+Xfj6KACC9CGGnIJ2FlRrG0kbe8etQNNJY5My8+etbheC9o44WcMcB78sw4hbC4ggS+xNoArL1W6wWQAeLvAlKHNnUSCaUSTc6C4dQto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V1v7S0LsHz4f3lfY
	for <netfs@lists.linux.dev>; Sat, 23 Mar 2024 17:30:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 123831A0172
	for <netfs@lists.linux.dev>; Sat, 23 Mar 2024 17:30:36 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn+RE3of5lWWlNHw--.24449S4;
	Sat, 23 Mar 2024 17:30:35 +0800 (CST)
From: yangerkun <yangerkun@huawei.com>
To: dhowells@redhat.com,
	jlayton@kernel.org,
	hsiangkao@linux.alibaba.com,
	netfs@lists.linux.dev
Cc: yangerkun@huawei.com
Subject: [PATCH] netfs: fix the mismatch used for CONFIG_FSCACHE_DEBUG
Date: Sat, 23 Mar 2024 17:23:12 +0800
Message-Id: <20240323092312.1643320-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn+RE3of5lWWlNHw--.24449S4
X-Coremail-Antispam: 1UD129KBjvdXoWrtw18KFykuF1fAw1kWw4UJwb_yoW3urg_t3
	WxAF18Wrs8tFnYqrWSk3y0kFy5W3ykKa18uw13trZ3trZ09F98CFsagrZ3AwsxXr45Wr9x
	twnYqrs8Zry7GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbIxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij
	64vIr41l42xK82IY64kExVAvwVAq07x20xyl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r12
	6r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU1nYFJUUUUU==
Sender: yangerkun@huaweicloud.com
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

The name of debug config used in fs/netfs/internal.h has a mismatch
compared to the define in fs/netfs/Kconfig, which lead to that debug for
netfs won't work.

Signed-off-by: yangerkun <yangerkun@huawei.com>
---
 fs/netfs/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index ec7045d24400..53d61ead35fd 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -349,7 +349,7 @@ void fscache_create_volume(struct fscache_volume *volume, bool wait);
 #define _leave(FMT, ...) kleave(FMT, ##__VA_ARGS__)
 #define _debug(FMT, ...) kdebug(FMT, ##__VA_ARGS__)
 
-#elif defined(CONFIG_NETFS_DEBUG)
+#elif defined(CONFIG_FSCACHE_DEBUG)
 #define _enter(FMT, ...)			\
 do {						\
 	if (netfs_debug)			\
-- 
2.39.2

