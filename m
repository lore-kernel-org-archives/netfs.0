Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC76A1103
	for <netfs@lists.linux.dev>; Wed, 22 May 2024 03:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716349801; cv=none; b=uhuT9Lb/HONVPwdDJGH6GBv5HCP3upOgOBfaXCqDyy32/WGiKwRo/6+Uww0+WeJk/UATk+K75amTjmgUwOIEDDm9JD5i+eVJSVNSi1K/DVkwwu2REhZyZkf+5xf8R/2LZkP2i37khsF19wp1GcSi4QpQtcEs95s1G4GBPzvvGyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716349801; c=relaxed/simple;
	bh=wtHFyT+WV/JOtImQfo2izad58zTH2/4Z1AicKzNcIUw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=It7LtPSfWrgPGi5UdV1y8Kb3lT3D0brNt5gO1MC0u0I7JbTXN5eZEqHhHTutuOa7UF1RgVKxwB8umsLdSXKqaJJgqbWnyY04P3Lu4f3S45m6ERCxI8ZBtyWQxt9gdlLUV4kc9W7wS8alAhGeVUUwvjaRprg/FJauvIkhc0Ok2GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Vkckd5xSvz4f3jcy
	for <netfs@lists.linux.dev>; Wed, 22 May 2024 11:49:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id BBCEA1A0A90
	for <netfs@lists.linux.dev>; Wed, 22 May 2024 11:49:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBFea01mxlBXNQ--.57627S4;
	Wed, 22 May 2024 11:49:52 +0800 (CST)
From: libaokun@huaweicloud.com
To: netfs@lists.linux.dev,
	dhowells@redhat.com,
	jlayton@kernel.org
Cc: hsiangkao@linux.alibaba.com,
	jefflexu@linux.alibaba.com,
	zhujia.zj@bytedance.com,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	libaokun@huaweicloud.com,
	yangerkun@huawei.com,
	houtao1@huawei.com,
	yukuai3@huawei.com,
	wozizhi@huawei.com,
	Baokun Li <libaokun1@huawei.com>
Subject: [PATCH v3 00/12] cachefiles: some bugfixes and cleanups for ondemand requests
Date: Wed, 22 May 2024 19:42:56 +0800
Message-Id: <20240522114308.2402121-1-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHGBFea01mxlBXNQ--.57627S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGr18JFyUXF47JFy3uw4xCrg_yoW5tw4fpF
	WSk3Wakr18Wr48C3s7Ar4fJryrG3yxAF9FgrnFq34DZwn8Xr1FvrW0qr1Yqas8CrZ7Gw4a
	q3WUuas7tw1q93DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB214x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAq
	YI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRuWlkUUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/

From: Baokun Li <libaokun1@huawei.com>

Hi all!

This is the third version of this patch series. The new version has no
functional changes compared to the previous one, so I've kept the previous
Acked-by and Reviewed-by, so please let me know if you have any objections.

Thank you, Jia Zhu and Jingbo Xu, Jeff Layton, Gao Xiang, for the feedback
in the previous version.

We've been testing ondemand mode for cachefiles since January, and we're
almost done. We hit a lot of issues during the testing period, and this
patch set fixes some of the issues related to ondemand requests.
The patches have passed internal testing without regression.

The following is a brief overview of the patches, see the patches for
more details.

Patch 1-5: Holding reference counts of reqs and objects on read requests
to avoid malicious restore leading to use-after-free.

Patch 6-10: Add some consistency checks to copen/cread/get_fd to avoid
malicious copen/cread/close fd injections causing use-after-free or hung.

Patch 11: When cache is marked as CACHEFILES_DEAD, flush all requests,
otherwise the kernel may be hung. since this state is irreversible, the
daemon can read open requests but cannot copen.

Patch 12: Allow interrupting a read request being processed by killing
the read process as a way of avoiding hung in some special cases.

Comments and questions are, as always, welcome.
Please let me know what you think.

Thanks,
Baokun

Changes since v2:
  * Collect Acked-by from Jeff Layton.(Thanks for your ack!)
  * Collect RVB from Gao Xiang and Jingbo Xu.(Thanks for your review!)
  * Pathch 9: Rename anon_file to ondemand_anon_file to avoid possible
    conflicts with generic code.
  * Pathch 12: Add cachefiles_ondemand_finish_req() helper function to
    simplify the code.
  * Adjust the patch order as suggested to facilitate backporting to
    the STABLE version.
    * The current patch 1 is the previous patch 5;
    * The current patch 5 is the previous patch 2;

Changes since v1:
  * Collect RVB from Jia Zhu and Jingbo Xu.(Thanks for your review!)
  * Pathch 1: Add Fixes tag and enrich the commit message.
  * Pathch 7: Add function graph comments.
  * Pathch 8: Update commit message and comments.
  * Pathch 9: Enriched commit msg.

[V1]: https://lore.kernel.org/all/20240424033916.2748488-1-libaokun@huaweicloud.com
[V2]: https://lore.kernel.org/all/20240515084601.3240503-1-libaokun@huaweicloud.com


Baokun Li (11):
  cachefiles: add output string to cachefiles_obj_[get|put]_ondemand_fd
  cachefiles: remove requests from xarray during flushing requests
  cachefiles: fix slab-use-after-free in cachefiles_ondemand_get_fd()
  cachefiles: fix slab-use-after-free in
    cachefiles_ondemand_daemon_read()
  cachefiles: remove err_put_fd label in
    cachefiles_ondemand_daemon_read()
  cachefiles: add consistency check for copen/cread
  cachefiles: add spin_lock for cachefiles_ondemand_info
  cachefiles: never get a new anonymous fd if ondemand_id is valid
  cachefiles: defer exposing anon_fd until after copy_to_user() succeeds
  cachefiles: flush all requests after setting CACHEFILES_DEAD
  cachefiles: make on-demand read killable

Zizhi Wo (1):
  cachefiles: Set object to close if ondemand_id < 0 in copen

 fs/cachefiles/daemon.c            |   3 +-
 fs/cachefiles/internal.h          |   5 +
 fs/cachefiles/ondemand.c          | 217 ++++++++++++++++++++++--------
 include/trace/events/cachefiles.h |   8 +-
 4 files changed, 176 insertions(+), 57 deletions(-)

-- 
2.39.2

